# QOI or Quite OK Image in Crystal
module Qoi
  VERSION = "0.1.0"

  # CONSTANTS
  
  QOI_OP_INDEX = 0x00
  QOI_OP_DIFF  = 0x40
  QOI_OP_LUMA  = 0x80
  QOI_OP_RUN   = 0xc0
  QOI_OP_RGB   = 0xfe
  QOI_OP_RGBA  = 0xff
  QOI_MASK_2   = 0xc0
  QOI_MAGIC    = 'q'.ord.to_u32 << 24_u32 | 'o'.ord.to_u32 << 16_u32 | 'i'.ord.to_u32 << 8_u32 | 'f'.ord.to_u32
  QOI_PIXELS_MAX = 400000000_u32
  QOI_PADDING = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01}

  # Pixel

  struct Pixel
    property r : UInt8
    property g : UInt8
    property b : UInt8
    property a : UInt8
    def initialize(@r : UInt8, @g : UInt8, @b : UInt8, @a : UInt8)
    end
  end

  def _qoi_color_hash(p : Pixel)
    p.r * 3 + p.g * 5 + p.b * 7 + p.a * 11
  end

  # QOIHeader

  enum QOIChannel : UInt8
    QOI_RGB  = 0x03
    QOI_RGBA = 0x04
  end

  enum QOIColorSpace : UInt8
    QOI_SRGB   = 0x00
    QOI_LINEAR = 0x01
  end

  struct QOIHeader
    getter width            : UInt32
    getter height           : UInt32
    getter channels         : QOIChannel
    getter colorspace       : QOIColorSpace
    def initialize(@width : UInt32, @height : UInt32, @channels : QOIChannel, @colorspace : QOIColorSpace)
      if @width == 0
        throw_invalid_header_width(@width)
      end
      if @height == 0 
        throw_invalid_header_height(@height)
      end
      if @channels.value < 3 || @channels.value > 4
        throw_invalid_header_channels(@channels.value)
      end
      if @colorspace.value > 1
        throw_invalid_header_colorspace(@colorspace.value)
      end

    end
    
    def initialize(@width : UInt32, @height : UInt32, channels : UInt8 , colorspace : UInt8)
      if @width == 0
        throw_invalid_header_width(@width)
      end
      if @height == 0 
        throw_invalid_header_height(@height)
      end
      if channels < 3 || channels > 4
        throw_invalid_header_channels(channels)
      end
      if colorspace > 1
        throw_invalid_header_colorspace(colorspace)
      end
      @channels = QOIChannel.new(channels)
      @colorspace = QOIColorSpace.new(colorspace)
    end

    class QOIError < Exception
      def initialize(msg : String)
        super "#{msg}"
      end
    end

    def throw_magic_bytes_error(magic : UInt32)
      raise QOIError.new "invalid magic bytes, got #{magic}, expected #{QOI_MAGIC}."
    end

    def throw_invalid_header_width(width : UInt32)
      raise QOIError.new "invalid width in header, got #{width}"
    end

    def throw_invalid_header_height(height : UInt32)
      raise QOIError.new "invalid height in header, got #{height}"
    end

    def throw_invalid_header_channels(channels : UInt8)
      raise QOIError.new "invalid channels in header, got #{channels}"
    end

    def throw_invalid_header_colorspace(colorspace : UInt8)
      raise QOIError.new "invalid colorspace in header, got #{colorspace}"
    end

    def throw_unexpected_eof()
      raise QOIError.new "unexpected end of file"
    end
  end
    
  # TODO: add decoder and encoders
end

