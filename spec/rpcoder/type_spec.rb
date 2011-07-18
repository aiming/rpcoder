# encoding: utf-8

module RPCoder
  describe "Type" do
    context do
      let(:one) { 1 }

      before do
        @type = Type.new
        @type.add_field :name, :type, :options
      end

      subject { @type.fields }

      it { should be_an_instance_of Array }
      it { should have(one).item }
      it { @type.fields.first.should be_an_instance_of Type::Field }
    end
  end
end

