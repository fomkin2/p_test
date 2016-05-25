class Menu < ActiveRecord::Base
  belongs_to :menu_type
  belongs_to :page
  belongs_to :menu

  def self.link_menu_type
    MenuType.find_by_title 'link'
  end

  def self.page_menu_type
    MenuType.find_by_title 'page'
  end

  def self.sub_menu_menu_type
    MenuType.find_by_title 'sub_menu'
  end

  def self.add_menu position, menu_hash, parent = nil
    menu_hash.each_with_index do |(key, value), index|
      ordering = menu_hash.size - index
      menu_item = add_menu_item position, key, value, ordering, parent
      if value[:sub_menu].present?
        add_menu position, value[:sub_menu], menu_item
      end
    end
  end

  def self.add_menu_item position, title, attributes, ordering, parent
    if attributes[:type] == 'link'
      return menu = create(
        position: position,
        menu_type: link_menu_type,
        ordering: ordering,
        url: attributes[:url],
        title: title,
        menu: parent
      )
    end
    if attributes[:type] == 'page'
      page = Page.find_by_uid title
      if page.blank?
        page = Page.create(
          title: title,
          uid: title,
          content: "new #{title}",
        )
      end
      return create(
        position: position,
        menu_type: page_menu_type,
        ordering: ordering,
        menu: parent,
        page: page
      )
    end
    if attributes[:type] == 'sub_menu'
      return create(
        position: position,
        menu_type: sub_menu_menu_type,
        ordering: ordering,
        title: title
      )
    end
  end

end
