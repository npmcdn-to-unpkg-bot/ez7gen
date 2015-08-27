require "minitest/autorun"
require_relative '../lib/ez7gen/profile_parser'

class TestProfileParser < MiniTest::Unit::TestCase
	
	def setup
		@parser = ProfileParser.new('2.4', 'ADT_A01')
	end

	def test_init
		assert(@parser !=nil)
		# assert(hl7 != nil)
		# refute_nil(hl7)
	end

	def test_getSegmentStructure
   	 puts @parser.getSegmentStructure('[~{~AL1~}~]')
   	 al1 =  @parser.getSegmentStructure('[~{~AL1~}~]')
   	 #assert_equal('Set ID - AL1', al1[0]['description'])
   end
exit
	def test_getMessageStructrue
		expected = "MSH~EVN~PID~[~PD1~]~[~{~ROL~}~]~[~{~NK1~}~]~PV1~[~PV2~]~[~{~ROL~}~]~[~{~DB1~}~]~[~{~OBX~}~]~[~{~AL1~}~]~[~{~DG1~}~]~[~DRG~]~[~{~PR1~[~{~ROL~}~]~}~]~[~{~GT1~}~]~[~{~IN1~[~IN2~]~[~{~IN3~}~]~[~{~ROL~}~]~}~]~[~ACC~]~[~UB1~]~[~UB2~]~[~PDA~]"
		assert_equal(expected, @parser.getMessageStructure())
	end

   def test_processSegments
   		struct = "MSH~EVN~PID~[~PD1~]~[~{~ROL~}~]~[~{~NK1~}~]~PV1~[~PV2~]~[~{~ROL~}~]~[~{~DB1~}~]~[~{~OBX~}~]~[~{~AL1~}~]~[~{~DG1~}~]~[~DRG~]~[~{~PR1~[~{~ROL~}~]~}~]~[~{~GT1~}~]~[~{~IN1~[~IN2~]~[~{~IN3~}~]~[~{~ROL~}~]~}~]~[~ACC~]~[~UB1~]~[~UB2~]~[~PDA~]"
   		results = @parser.processSegments(struct)
   		assert_equal(2, results.size())
   		assert_equal(21, results[:segments].size())
   		assert_equal('[~PD1~]', results[:segments][0])
   end

   def test_codeTable
   		attributes = @parser.getCodeTable("62")
   		p attributes[0].class

   		# assert_equal(3, attributes.size)
   		attributes.each do |atr|   puts atr end
   		assert_equal('1', attributes[0]['position'])
   		assert_equal('02', attributes[1]['value'])   		
   		assert_equal('Census management', attributes[2]['description'])
   end

   def test_getSegments
   	 results =  @parser.getSegments
	 assert_equal(21, results[:segments].size())
	 assert_equal('[~PD1~]', results[:segments][0])
   end

end