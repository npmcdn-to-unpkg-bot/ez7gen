# require "minitest/autorun"
require "benchmark"
require 'test/unit'
require 'ruby-hl7'
# require_relative "../lib/ez7gen/service/segment_generator"
require_relative "../lib/ez7gen/structure_parser"

class StructureParserTest < Test::Unit::TestCase
 #parse xml once
  # TESTS #
  # def setup
  #   puts Benchmark.measure{
  #     # pp = ProfilerParser.new(@attrs).generate()
  #     profilers = { 'primary'=> @@pp }
  #   @segmentGen = SegmentGenerator.new("2.4","ADT_A01", profilers)
  #   # @msg = HL7::Message.new
  #   # @msg << @segmentGen.init_msh()
  #   }
  #
  # end

 def test_init
   parser = StructureParser.new()
   assert_equal([],parser.encodedSegments)
   assert_equal(0, parser.idx)

   # puts @msg
 end

 def test_process_opt
   parser = StructureParser.new()
   struct = 'MSH~[~{~NTE~}~]~[~PID~[~PD1~]~[~{~NTE~}~]~[~PV1~[~PV2~]~]~[~{~IN1~[~IN2~]~[~IN3~]~}~]~[~GT1~]~[~{~AL1~}~]~]~{~ORC~OBR~[~{~NTE~}~]~[~CTD~]~[~{~DG1~}~]~[~{~OBX~[~{~NTE~}~]~}~]~{~[~[~PID~[~PD1~]~]~[~PV1~[~PV2~]~]~[~{~AL1~}~]~{~[~ORC~]~OBR~[~{~NTE~}~]~[~CTD~]~{~OBX~[~{~NTE~}~]~}~}~]~}~[~{~FT1~}~]~[~{~CTI~}~]~[~BLG~]~}'
   # regEx = parser.regExOp
   # parser.process(struct, regEx, '[]')
   parser.process_opt_groups(struct)
   # assert_equal 29,parser.idx
   assert_equal 29,parser.encodedSegments.size
   puts struct
 end

 def test_process_rep
   parser = StructureParser.new()
   struct = 'MSH~[~{~NTE~}~]~[~PID~[~PD1~]~[~{~NTE~}~]~[~PV1~[~PV2~]~]~[~{~IN1~[~IN2~]~[~IN3~]~}~]~[~GT1~]~[~{~AL1~}~]~]~{~ORC~OBR~[~{~NTE~}~]~[~CTD~]~[~{~DG1~}~]~[~{~OBX~[~{~NTE~}~]~}~]~{~[~[~PID~[~PD1~]~]~[~PV1~[~PV2~]~]~[~{~AL1~}~]~{~[~ORC~]~OBR~[~{~NTE~}~]~[~CTD~]~{~OBX~[~{~NTE~}~]~}~}~]~}~[~{~FT1~}~]~[~{~CTI~}~]~[~BLG~]~}'
   # regEx = parser::REGEX_REP
   # parser.process(struct, regEx, parser::PRNTHS_REP)# {}
   parser.process_rep_groups(struct)
   # assert_equal 17,parser.idx
   assert_equal 17,parser.encodedSegments.size
   puts struct
 end

  def test_process_not_optional_group
    # <MessageStructure name='ADT_A45' definition='MSH~EVN~PID~[~PD1~]~{~MRG~PV1~}' />
    parser = StructureParser.new()
    struct = "MSH~MSA~[~ERR~]~QAK~QPD~{~[~PID~[~PD1~]~[~QRI~]~]~}~[~DSC~]"
    # regEx = parser.regExOp
    # parser.process(struct, regEx, '[]')
    # # assert_equal 17,parser.encodedSegments.size
    # p parser.encodedSegments
    # puts struct
    #
    # regEx = parser.regExRep
    # parser.process(struct, regEx, '{}')
    parser.process_struct(struct)
    p parser.encodedSegments
    p struct

    # ["[~ERR~]", "[~PD1~]", "[~QRI~]", "[~PID~1~2~]", "{~3~}", "[~DSC~]"]
    #["MSH", "MSA", 0, "QAK", "QPD", 4, 5]
  end

 def test_process_struct
   parser = StructureParser.new()
   struct = 'MSH~[~{~NTE~}~]~[~PID~[~PD1~]~[~{~NTE~}~]~[~PV1~[~PV2~]~]~[~{~IN1~[~IN2~]~[~IN3~]~}~]~[~GT1~]~[~{~AL1~}~]~]~{~ORC~OBR~[~{~NTE~}~]~[~CTD~]~[~{~DG1~}~]~[~{~OBX~[~{~NTE~}~]~}~]~{~[~[~PID~[~PD1~]~]~[~PV1~[~PV2~]~]~[~{~AL1~}~]~{~[~ORC~]~OBR~[~{~NTE~}~]~[~CTD~]~{~OBX~[~{~NTE~}~]~}~}~]~}~[~{~FT1~}~]~[~{~CTI~}~]~[~BLG~]~}'
   # regEx = parser::REGEX_REP
   # parser.process(struct, regEx, parser::PRNTHS_REP)# {}
   parser.process_struct(struct)
   # assert_equal 17,parser.idx
   # assert_equal 17,parser.encodedSegments.size
   p parser.encodedSegments
   puts struct
 end

  def test_process_struct_ADT_A01
    struct = "MSH~EVN~PID~[~PD1~]~[~{~ROL~}~]~[~{~NK1~}~]~PV1~[~PV2~]~[~{~ROL~}~]~[~{~DB1~}~]~[~{~OBX~}~]~[~{~AL1~}~]~[~{~DG1~}~]~[~DRG~]~[~{~PR1~[~{~ROL~}~]~}~]~[~{~GT1~}~]~[~{~IN1~[~IN2~]~[~{~IN3~}~]~[~{~ROL~}~]~}~]~[~ACC~]~[~UB1~]~[~UB2~]~[~PDA~]"
    parser = StructureParser.new()
    parser.process_struct(struct)
    # assert_equal 17,parser.idx
    # assert_equal 17,parser.encodedSegments.size
    p parser.encodedSegments
    puts struct
  # ["MSH", "EVN", "PID", 0, 1, 2, "PV1", 3, 4, 5, 6, 7, 8, 9, 11, 12, 16, 17, 18, 19, 20]
  # ["[~PD1~]", "[~{~ROL~}~]", "[~{~NK1~}~]", "[~PV2~]", "[~{~ROL~}~]", "[~{~DB1~}~]", "[~{~OBX~}~]", "[~{~AL1~}~]", "[~{~DG1~}~]", "[~DRG~]", "[~{~ROL~}~]", "[~{~PR1~10~}~]", "[~{~GT1~}~]", "[~IN2~]", "[~{~IN3~}~]", "[~{~ROL~}~]", "[~{~IN1~13~14~15~}~]", "[~ACC~]", "[~UB1~]", "[~UB2~]", "[~PDA~]"]
 end

end