const webpack = require('webpack');
const babel_options = { presets: ['es2015'], compact: false }

module.exports = {
  entry: `${__dirname}/src/index`,
  output: {
    path: `${__dirname}/../public`,
    filename: 'bundle.js'
  },

  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot',
      moment: 'moment',
      request: 'superagent',
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.AggressiveMergingPlugin(),
    // new webpack.optimize.UglifyJsPlugin(),
  ],
  module: {
    loaders: [
      { test: /\.tag$/, loader: `babel?${JSON.stringify(babel_options)}!riotjs` },
      { test: /\.js$/, loader: `babel?${JSON.stringify(babel_options)}` },
      { test: /\.css$/, loader: 'style!css' },
      { test: /\.(eot|woff2?|ttf|svg)$/, loader: 'file' },
    ]
  },

  devtool: "#source-map",

  devServer: {
    contentBase: `${__dirname}/../public`
  }
};

