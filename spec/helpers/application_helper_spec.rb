require 'rails_helper'
describe ApplicationHelper do
  describe "#render_markdown" do
    it "converts markdown to html" do
      html = helper.render_markdown("**bold** *italics*")
      expect(html).to eq "<p><strong>bold</strong> <em>italics</em></p>\n"
    end

    it "converts nil without error" do
      expect { helper.render_markdown(nil) }.to_not raise_error
    end

  end
end
