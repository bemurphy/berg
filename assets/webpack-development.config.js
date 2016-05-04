var fs = require("fs");
var glob = require("glob");
var path = require("path");
var webpack = require("webpack");
var loadConfig = require("./config");

/**
 * General configuration
 */
var config  = loadConfig(path.join(__dirname, "config.yml"));
var BASE      = path.join(__dirname, "..")
var APPS_BASE = path.join(BASE, "/apps")
var APPS      = glob.sync(APPS_BASE + "/*");
var BUILD     = path.join(__dirname, "build");
var DEVELOPMENT_HOST = config.ASSETS_DEVELOPMENT_SERVER_HOST || "localhost";
var DEVELOPMENT_PORT = config.ASSETS_DEVELOPMENT_SERVER_PORT || 8080;

/**
 * Custom webpack plugins
 */
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var WebpackNotifierPlugin = require("webpack-notifier");

/**
 * PostCSS packages
 */
var cssimport = require("postcss-import");
var cssnext = require("postcss-cssnext");
var modulesValues = require("postcss-modules-values");

/**
 * createEntries
 *
 * Iterate through the `APPS`, find any matching `target.js` files, and
 * return those as entry points for the webpack output.
 */

function createEntries(entries, dir) {
  var app = path.basename(dir);
  var targets = glob.sync(dir + "/**/target.js");

  targets.forEach(function(target) {
    var targetName = path.basename(path.dirname(target));
    entries[app + "__" + targetName] = [
      "webpack-dev-server/client?http://localhost:8080",
      "webpack/hot/dev-server",
      target
    ];
  });

  return entries;
}

/**
 * Plugin setup
 */

var plugins = [
  new webpack.NoErrorsPlugin(),
  new webpack.HotModuleReplacementPlugin(),
  new webpack.DefinePlugin({
    DEVELOPMENT: true
  }),
  // Extract all CSS into static files
  new ExtractTextPlugin("[name].css", {
    allChunks: true
  })
];

// Enable the webpack notifier plugin unless explicitly disabled in the
// ENV setup.
if (config.DISABLE_ASSETS_NOTIFIER === undefined) {
  plugins.push(
    new WebpackNotifierPlugin({title: "Webpack assets"})
  );
}

/**
 * Webpack configuration
 */
module.exports = {
  // Set the context as the apps directory
  context: APPS_BASE,

  // Generate the `entry` points from the filesystem
  entry: APPS.reduce(createEntries, {}),

  // Configure output
  output: {
    // Output into our build directory
    path: BUILD,
    // Template based on keys in entry above
    // Generate hashed names for production
    filename: "[name].js",
    // Ensure the publicPath matches the expected location in development
    publicPath: "http://" + DEVELOPMENT_HOST + ":"+ DEVELOPMENT_PORT + "/assets/"
  },

  // Plugin definitions
  plugins: plugins,

  // Post-CSS configiruation
  postcss: function(webpack) {
    return {
      defaults: [
        modulesValues,
        cssimport({
          addDependencyTo: webpack
        }),
        cssnext()
      ]
    };
  },

  // eslint configuration
  eslint: {
    configFile: path.join(__dirname, "../.eslintrc.json"),
    emitError: false,
    emitWarning: true
  },

  // Resolve formalist-theme and shared
  resolve: {
    alias: {
      "shared": path.join(__dirname, "shared"),
      "formalist-theme": 'formalist-standard-react/lib/components/ui'
    },
    moduleDirectories: [
      path.join(__dirname, '../node_modules'),
      path.join(__dirname, '../node_modules/roneo/node_modules')
    ],
    fallback: [
      path.join(__dirname, '../node_modules'),
      path.join(__dirname, '../node_modules/roneo/node_modules')
    ]
  },

  // Same issue, for loaders like babel
  resolveLoader: {
    fallback: [
      path.join(__dirname, '../node_modules')
    ]
  },

  // General configuration
  module: {
    loaders: [
      {
        test: require.resolve('turbolinks'),
        loader: 'imports?this=>window'
      },
      {
        test: /\.js/,
        loaders: [
          "babel?presets[]=react,presets[]=es2015",
          "eslint-loader"
        ],
        include: APPS
      },
      {
        test: /\.(jpe?g|png|gif|svg|woff|ttf|otf|eot|ico)/,
        loader: "file-loader?name=[path][name].[ext]"
      },
      {
        test: /\.html$/,
        loader: "html-loader"
      },
      {
        test: /\.mcss$/,
        // The ExtractTextPlugin pulls all CSS out into static files
        // rather than inside the JavaScript/webpack bundle
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!postcss-loader')
      },
      {
        test: /\.css$/,
        // The ExtractTextPlugin pulls all CSS out into static files
        // rather than inside the JavaScript/webpack bundle
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader!postcss-loader')
      }
    ]
  }
};
