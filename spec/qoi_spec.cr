require "./spec_helper"
describe Qoi do
  it "is okay" do
    Qoi::QOI_MAGIC.should eq 0x716f6966
  end
end
