Deface::Override.new(
  :virtual_path  => "spree/admin/shared/_configuration_menu",
  :name          => "add_admin_local_tax",
  :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
  :text          => "<%= configurations_sidebar_menu_item Spree.t(:local_tax), spree.admin_local_taxes_path %>")
