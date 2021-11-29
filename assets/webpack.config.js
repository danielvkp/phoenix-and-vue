const path = require('path')
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const {
  VueLoaderPlugin
} = require('vue-loader')

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true,
        sourceMap: false
      }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    main: path.resolve(__dirname, './src/app.js'),
  },
  output: {
    path: path.resolve(__dirname, '../priv/static/assets'),
    filename: '[name].js',
    chunkFilename: 'assets/[name].[chunkhash].js'
  },
  resolve: {
    extensions: ['.js', '.vue', '.json', '.css', '.scss', '.styl'],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
    }
  },
  module: {
    rules: [{
        test: /\.vue$/,
        use: {
          loader: 'vue-loader',
          options: {
            plugins: [
              "@babel/plugin-syntax-dynamic-import"
            ]
          }
        }
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            plugins: [
              "@babel/plugin-syntax-dynamic-import"
            ]
          }
        }
      },
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader']
      },
      {
        test: /\.(jpg|png|gif)$/,
        loader: "file-loader",
        options: {
          name: "[name].[ext]",
          outputPath: "../static/images/",
          publicPath: "../images/"
        }
      }
    ],
  },
  plugins: [
    new VueLoaderPlugin(),
    new MiniCssExtractPlugin({
      experimentalUseImportModule: true,
    }),
    /*new CopyWebpackPlugin({
      patterns: [{
        from: 'static/',
        to: '../'
      }, ]
    })*/
  ]
})