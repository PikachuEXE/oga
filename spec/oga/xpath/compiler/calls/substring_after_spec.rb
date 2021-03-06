require 'spec_helper'

describe Oga::XPath::Compiler do
  describe 'substring-after() function' do
    before do
      @document = parse('<root><a>-</a><b>a-b-c</b></root>')

      @a1 = @document.children[0].children[0]
    end

    describe 'at the top-level' do
      it 'returns the substring of the 1st string after the 2nd string' do
        evaluate_xpath(@document, 'substring-after("a-b-c", "-")').should == 'b-c'
      end

      it 'returns an empty string if the 2nd string is not present' do
        evaluate_xpath(@document, 'substring-after("a-b-c", "x")').should == ''
      end

      it 'returns the substring of the 1st node set after the 2nd string' do
        evaluate_xpath(@document, 'substring-after(root/b, "-")').should == 'b-c'
      end

      it 'returns the substring of the 1st node set after the 2nd node set' do
        evaluate_xpath(@document, 'substring-after(root/b, root/a)')
          .should == 'b-c'
      end

      it 'returns an empty string when using two empty strings' do
        evaluate_xpath(@document, 'substring-after("", "")').should == ''
      end
    end

    describe 'in a predicate' do
      it 'returns a NodeSet containing all matching nodes' do
        evaluate_xpath(@document, 'root/a[substring-after("foo-bar", "-")]')
          .should == node_set(@a1)
      end
    end
  end
end
