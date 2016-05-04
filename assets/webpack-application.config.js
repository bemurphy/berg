var path = require("path");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  // Resolve formalist-theme and shared
  resolve: {
    alias: {
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

  module: {
    loaders: [
      {
        test: require.resolve('turbolinks'),
        loader: 'imports?this=>window'
      },
      {
        test: /\.mcss$/,
        // The ExtractTextPlugin pulls all CSS out into static files
        // rather than inside the JavaScript/webpack bundle
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]!postcss-loader')
      },
    ]
  }
}
