var path = require('path');
var webpack = require('webpack');
var UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = {
  entry: './build/build.ts',
  output: {
    path: path.resolve(__dirname, '../static/js'),
    filename: 'build.js',
  },
  module: {
    rules: [
      { test: /\.ts$/, loader: 'ts-loader', exclude: '/node_modules/' },
	]
  },
  devServer: {
    contentBase: path.resolve(__dirname, '../deploy/html'),
    publicPath: '../deploy/html/',
    host: '127.0.0.1',
    port: 8080,
    open: true
  },
  resolve: {
    extensions: ['.ts', '.js']
  },
  plugins: [
	  new UglifyJsPlugin(),
    new webpack.DefinePlugin({
      API_URL: JSON.stringify("https://app.rebuildeq.com")
    })
  ]
};