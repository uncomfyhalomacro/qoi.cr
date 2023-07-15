require "./spec_helper"
describe Qoi do
  describe "#errors" do
    it "errors with zero width or/and height" do
      expect_raises(Qoi::QOIHeader::QOIError) do
        Qoi::QOIHeader.new(0_u32, 0_u32, Qoi::QOIChannel.new(0x03), Qoi::QOIColorSpace.new(0x00))
      end
    end
    it "errors with invalid channel" do
      expect_raises(Qoi::QOIHeader::QOIError) do
        Qoi::QOIHeader.new(0_u32, 0_u32, Qoi::QOIChannel.new(0x00), Qoi::QOIColorSpace.new(0x00))
      end
    end
    it "errors with invalid colorspaces" do
      expect_raises(Qoi::QOIHeader::QOIError) do
        Qoi::QOIHeader.new(0_u32, 0_u32, Qoi::QOIChannel.new(0x03), Qoi::QOIColorSpace.new(0x05))
      end
    end
  end
  describe "#successes" do
    it "is succesful with correct params" do
      Qoi::QOI_MAGIC.should eq 0x716f6966
      header = Qoi::QOIHeader.new(1_u32, 1_u32, Qoi::QOIChannel.new(0x04), Qoi::QOIColorSpace.new(0x01))
    end
  end
end
