require "./spec_helper"
describe Qoi do
  describe "#errors" do
    it "errors with zero width or/and height" do
      expect_raises(Qoi::QOIHeader::QOIError, "invalid width in header, got 0") do
        Qoi::QOIHeader.new(0_u32, 0_u32, Qoi::QOIChannel::QOI_RGBA, Qoi::QOIColorSpace::QOI_SRGB)
      end
    end
  end
  describe "#successes" do
    it "is succesful with correct params" do
      Qoi::QOI_MAGIC.should eq 0x716f6966
      header = Qoi::QOIHeader.new(1_u32, 1_u32, Qoi::QOIChannel::QOI_RGBA, Qoi::QOIColorSpace::QOI_SRGB)
    end
  end
end
