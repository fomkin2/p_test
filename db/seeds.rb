# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# admin account
Admin.delete_all
Admin.create email: 'admin@admin.com', password: 'password'

# banners
BannerPosition.delete_all
BannerPosition.create(description: '首页轮播', size: '720x215', id: 1)

# products
Product.delete_all
Product.create(
  title: '趴趴雅思口语答案卡片',
  ordering: 0
)
Product.create(
  title: '趴趴雅思作文原创范文模板',
  ordering: 0
)
Product.create(
  title: '趴趴雅思口语答案卡片',
  ordering: 0
)
Product.create(
  title: '趴趴雅思口语模考',
  ordering: 0
)
Product.create(
  title: '趴趴雅思听力原创网课',
  ordering: 0
)
Product.create(
  title: '趴趴雅思大小作文批改',
  ordering: 0
)
Product.create(
  title: '趴趴出国留学文书代写',
  ordering: 0
)
Product.create(
  title: '趴趴雅思阅读原创网课',
  ordering: 0
)
