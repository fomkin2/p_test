module ApplicationHelper

  def get_footer_menu_item menu_item
    html = ''

    if menu_item.menu_type == Menu.link_menu_type
      if request.fullpath == URI.escape(menu_item.url)
        html = html + '<li class="active">'
      else
        html = html + '<li>'
      end
      html = html + "<a href=\"#{menu_item.url}\">#{menu_item.title}</a>"
      html = html + '</li>'
      return html
    end

    if menu_item.menu_type == Menu.page_menu_type
      if params[:uid] == menu_item.page.uid
        html = html + '<li class="active">'
      else
        html = html + '<li>'
      end
      link = link_to menu_item.page.title, controller: '/pages', action: :show, uid: menu_item.page.uid
      html = html + link
      html = html + '</li>'
      return html
    end

  end


end
