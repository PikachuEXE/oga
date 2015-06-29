require 'spec_helper'

describe Oga::CSS::Parser do
  describe 'paths' do
    it 'parses a single path' do
      parse_css('foo').should == parse_xpath('descendant::foo')
    end

    it 'parses a path using a namespace' do
      parse_css('ns|foo').should == parse_xpath('descendant::ns:foo')
    end

    it 'parses a path using two selectors' do
      parse_css('foo bar').should ==
        parse_xpath('descendant::foo/descendant::bar')
    end

    it 'parses two paths separated by a comma' do
      parse_css('foo, bar').should ==
        parse_xpath('descendant::foo | descendant::bar')
    end

    it 'parses three paths separated by a comma' do
      parse_css('foo, bar, baz').should ==
        parse_xpath('descendant::foo | descendant::bar | descendant::baz')
    end
  end
end
