require 'spec_helper'

describe 'Node' do 
  subject { Node.new }
  it { is_expected.to respond_to(:children, :add_child, :parent, :add_to) }
  describe "#add_child" do 
    before { 
      @new_node = Node.new 
      subject.add_child(@new_node)
    }
    it "should add children to node" do 
      expect(subject.children).to include(@new_node)
    end
    it "should be the parent of new node" do 
      expect(@new_node.parent).to be(subject)
    end
  end
end
