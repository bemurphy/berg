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

/**
 * Custom webpack plugins
 */
var ExtractTextPlugin = require("extract-text-webpack-plugin");

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
 *
 * A target at `./apps/main/assets/public/target.js` will create an output file
 * name `main__public.js`
 */

function createEntries(entries, dir) {
  var app = path.basename(dir);
  var targets = glob.sync(dir + "/**/target.js");

  targets.forEach(function(target) {
    var targetName = path.basename(path.dirname(target));
    entries[app + "__" + targetName] = [target];
  });

  return entries;
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
    filename: "[name].js"
  },

  // Plugin/loader specific-configuration
  plugins: [
    new webpack.DefinePlugin({
      DEVELOPMENT: false,
      'process.env.NODE_ENV': '"production"'
    }),
    new ExtractTextPlugin("[name].css", {
      allChunks: true
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    })
  ],

  // Post-CSS configuration
  postcss: function() {
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

  // Quiet the output
  stats: {
    assets:       false,
    assetsSort:   false,
    cached:       false,
    children:     false,
    chunkModules: false,
    chunkOrigins: false,
    chunks:       false,
    chunksSort:   false,
    colors:       true,
    errorDetails: true,
    hash:         false,
    modules:      false,
    modulesSort:  false,
    reasons:      false,
    source:       false,
    timings:      false,
    version:      false
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
        loader: "babel?presets[]=react,presets[]=es2015",
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
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?modules&importLoaders=1!postcss-loader')
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
