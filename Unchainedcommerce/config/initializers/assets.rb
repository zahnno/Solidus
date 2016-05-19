# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Devise.secret_key = "2c2313c4160badd430b773bfc5050f4b1b93ed3f37eddd43386441e0873d9d6ee5f808c0b3323a75b8c0fc5913862e9c1977"