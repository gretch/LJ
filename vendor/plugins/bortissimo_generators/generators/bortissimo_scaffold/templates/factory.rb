Factory.define :<%= singular_name %> do |<%= singular_name %>|
<% for attribute in attributes -%>
  <%= singular_name %>.<%= attribute.name %> <%= attribute.default_value %>
<% end -%>
end
