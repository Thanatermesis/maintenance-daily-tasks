require 'spec_helper'

describe 'Node.new' do 
  subject { Node.new }
  it { is_expected.to respond_to(:children, :add_child, :parent, :add_to) }
  describe "#add_child" do 
    before { 
      @new_node = Node.new 
      subject.add_child(@new_node)
    }
    it "should add children to node" do 
      expect(subject.children).to include(@new_node)
      expect(subject.children.length).to be(1)
      expect(subject.children).to match_array([@new_node])
    end
    it "should be the parent of new node" do 
      expect(@new_node.parent).to be(subject)
    end
  end
  describe "#add_to" do 
    before { 
      @new_node = Node.new 
      subject.add_to(@new_node)
    }
    it "should be a child of new node" do 
      expect(@new_node.children).to include(subject)
    end
    it "should have the parent being  new node" do 
      expect(subject.parent).to be(@new_node)
    end
  end
  describe "#parent=" do 
    before { 
      @new_node = Node.new 
      subject.parent=(@new_node)
    }
    it "should be a child of new node" do 
      expect(@new_node.children).to include(subject)
    end
    it "should have the parent being  new node" do 
      expect(subject.parent).to be(@new_node)
    end
  end

  
end
