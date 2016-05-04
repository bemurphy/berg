var path = require("path");
var webpack = require("webpack");
var merge = require("webpack-merge");
var baseConfig = require('./webpack-base.config.js');
var commonConfig = require('./webpack-common.config.js');


/**
 * Webpack configuration
 */
 module.exports = merge(
  baseConfig({
    quiet: true
  }),
  commonConfig,
  {
    // Plugin/loader specific-configuration
    plugins: [
      new webpack.DefinePlugin({
        DEVELOPMENT: false,
        'process.env.NODE_ENV': '"production"'
      }),
      new webpack.optimize.UglifyJsPlugin({
        compress: {
          warnings: false
        }
      })
    ],
  }
);
