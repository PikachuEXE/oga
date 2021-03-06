require 'spec_helper'

describe Oga::XPath::Compiler do
  before do
    @document = parse('<root xmlns:x="x" foo="bar"><foo xmlns:y="y"></foo></root>')

    @ns_x = @document.children[0].namespaces['x']
    @ns_y = @document.children[0].children[0].namespaces['y']
  end

  describe 'relative to a document' do
    describe 'namespace::*' do
      it 'returns an empty NodeSet' do
        evaluate_xpath(@document).should == node_set
      end
    end

    describe 'root/namespace::x' do
      it 'returns a NodeSet' do
        evaluate_xpath(@document).should == node_set(@ns_x)
      end
    end

    describe 'root/foo/namespace::*' do
      it 'returns a NodeSet' do
        evaluate_xpath(@document).should == node_set(@ns_y, @ns_x)
      end
    end

    describe 'root/namespace::*' do
      it 'returns a NodeSet' do
        evaluate_xpath(@document).should == node_set(@ns_x)
      end
    end
  end

  describe 'relative to an element' do
    describe 'namespace::x' do
      it 'returns a NodeSet' do
        root = @document.children[0]

        evaluate_xpath(root).should == node_set(@ns_x)
      end
    end
  end

  describe 'relative to an attribute' do
    describe 'namespace::x' do
      it 'returns an empty NodeSet' do
        root = @document.children[0]

        evaluate_xpath(root.attribute('foo')).should == node_set
      end
    end
  end
end
