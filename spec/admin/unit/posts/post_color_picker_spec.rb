require "admin_app_helper"

RSpec.describe Admin::Persistence::PostColorPicker do
  subject(:post_color_picker) { Admin::Persistence::PostColorPicker.new(colors, recent_colors) }

  let(:colors) { {1 => "red", 2 =>  "green",  3 => "yellow", 4 => "blue"} }
  let(:recent_colors) { ->(){ ["red","green","yellow"] } }

  it "returns a color that isn't in the list of recent colors" do
    expect(post_color_picker.()).to eq "blue"
  end
end
