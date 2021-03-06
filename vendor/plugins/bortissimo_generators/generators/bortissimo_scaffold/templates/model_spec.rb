require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')

describe <%= class_name %> do
  before(:each) do
    @<%= singular_name %> = Factory.build(:<%= singular_name %>)
  end

  it 'should create a new instance given valid attributes' do
    violated "#{@<%= singular_name %>.errors.full_messages.to_sentence}" if @<%= singular_name %>.save == false
  end
end
