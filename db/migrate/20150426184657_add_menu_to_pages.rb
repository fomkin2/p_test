class AddMenuToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :menu, index: true
  end
end
