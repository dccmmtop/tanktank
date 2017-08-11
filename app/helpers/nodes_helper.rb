module NodesHelper
  def node_title_tag(node, opts = {})
    return t('nodes.node_was_deleted') if node.blank?
    path = main_app.node_path(node)   
    link_to(node.name, path)
  end
end
