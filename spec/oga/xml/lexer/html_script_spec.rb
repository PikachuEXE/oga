require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'HTML script elements' do
    it 'treats the content of a script tag as plain text' do
      lex_html('<script>foo <bar</script>').should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'script', 1],
        [:T_TEXT, 'foo ', 1],
        [:T_TEXT, '<', 1],
        [:T_TEXT, 'bar', 1],
        [:T_ELEM_END, nil, 1]
      ]
    end

    it 'treats style tags inside script tags as text' do
      lex_html('<script><style></style></script>').should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'script', 1],
        [:T_TEXT, '<', 1],
        [:T_TEXT, 'style>', 1],
        [:T_TEXT, '<', 1],
        [:T_TEXT, '/style>', 1],
        [:T_ELEM_END, nil, 1]
      ]
    end
  end
end
