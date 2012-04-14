require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Basic Element Methods" do
  class ElementMethodsShoeLaces
    attr_accessor :gui_container
    include Shoes::ElementMethods
  end

  Shoes.configuration.framework = 'white_shoes'

  before(:all) do
    #@gui = Shoes.app do
    #
    #
    #    button :text => "Change to Hello", :id => 'button_one'
    #
    #    button :text => 'Change to Goodbye', :id => 'button_two'
    #
    #end
  end

  describe "flow" do
    it "should use self, gui_container, opts, blk" do
      subject = ElementMethodsShoeLaces.new
      subject.gui_container = "gui_container"
      blk = lambda {}
      opts = mock(:hash)
      Shoes::Flow.should_receive(:new).
        with(subject, "gui_container", opts, blk)
      subject.flow opts, &blk
    end
  end

  describe "line" do
    shared_examples_for "basic line" do
      it { should be_instance_of(Shoes::Shape) }
      its(:top) { should eq(15) }
      its(:left) { should eq(10) }
      its(:width) { should eq(90) }
      its(:height) { should eq(45) }
    end

    context "created left-to-right, top-to-bottom" do
      subject { ElementMethodsShoeLaces.new.line(10, 15, 100, 60) }
      it_behaves_like "basic line"
    end

    context "specified right-to-left, top-to-bottom" do
      subject { ElementMethodsShoeLaces.new.line(100, 15, 10, 60) }
      it_behaves_like "basic line"
    end

    context "specified right-to-left, bottom-to-top" do
      subject { ElementMethodsShoeLaces.new.line(100, 60, 10, 15) }
      it_behaves_like "basic line"
    end

    context "specified left-to-right, bottom-to-top" do
      subject { ElementMethodsShoeLaces.new.line(10, 60, 100, 15) }
      it_behaves_like "basic line"
    end
  end

  describe "oval" do
    context "(eccentric)" do
      subject { ElementMethodsShoeLaces.new.oval(20, 30, 100, 200) }

      it { should be_instance_of(Shoes::Shape) }
      its (:top) { should eq(30) }
      its (:left) { should eq(20) }
      its (:width) { should eq(100) }
      its (:height) { should eq(200) }
    end

    shared_examples_for "circle" do
      it { should be_instance_of(Shoes::Shape) }
      its (:top) { should eq(30) }
      its (:left) { should eq(20) }
      its (:width) { should eq(100) }
      its (:height) { should eq(100) }
    end

    context "(circle) created with explicit arguments:" do
      context "width and height" do
        subject { ElementMethodsShoeLaces.new.oval(20, 30, 100, 100) }
        it_behaves_like "circle"
      end

      context "radius" do
        subject { ElementMethodsShoeLaces.new.oval(20, 30, 50) }
        it_behaves_like "circle"
      end
    end

    context "(circle) created with style hash:" do
      context "left, top, height, width" do
        subject { ElementMethodsShoeLaces.new.oval(left: 20, top: 30, width: 100, height: 100) }
        it_behaves_like "circle"
      end

      context "left, top, height, width, center: false" do
        subject { ElementMethodsShoeLaces.new.oval(left: 20, top: 30, width: 100, height: 100, center: false) }
        it_behaves_like "circle"
      end

      context "left, top, radius" do
        subject { ElementMethodsShoeLaces.new.oval(left: 20, top: 30, radius: 50) }
        it_behaves_like "circle"
      end

      context "left, top, width, height, center: true" do
        subject { ElementMethodsShoeLaces.new.oval(left: 70, top: 80, width: 100, height: 100, center: true) }
        it_behaves_like "circle"
      end
    end
  end

  describe "rgb" do
    subject { ElementMethodsShoeLaces.new.rgb(100, 149, 237) } # cornflower

    its(:class) { should eq(Shoes::Color) }
    its(:red) { should eq(100) }
    its(:green) { should eq(149) }
    its(:blue) { should eq(237) }
    its(:alpha) { should eq(Shoes::Color::OPAQUE) }
  end


  #it "Should return 0 for left for button_one" do
  #  @gui.elements['button_one'].left.should be 0
  #end
  #
  #it "Should return 0 for top of button_one" do
  #  @gui.elements['button_one'].top.should be 0
  #end
  #
  #it "Should return 0 for left for button_two" do
  #  @gui.elements['button_two'].left.should be 0
  #end
  #
  #it "Should return 0 for top for button_two" do
  #  @gui.elements['button_two'].top.should be 147
  #end
  #
  #it "Should make button_one invisible when hide is called" do
  #  @gui.elements['button_one'].hide
  #  @gui.elements['button_one'].to_java.isVisible.should be false
  #end
  #
  #it "Should make button_one visible when show is called" do
  #  @gui.elements['button_one'].hide
  #  @gui.elements['button_one'].show
  #  @gui.elements['button_one'].to_java.isVisible.should be true
  #end
  #
  #it "Should make button_one hidden when toggle is called and it is visible" do
  #  @gui.elements['button_one'].show
  #  @gui.elements['button_one'].toggle
  #  @gui.elements['button_one'].to_java.isVisible.should be false
  #end
  #
  #it "Should make button_one visible after being hidden when toggle is called and it is hidden" do
  #  @gui.elements['button_one'].hide
  #  @gui.elements['button_one'].toggle
  #  @gui.elements['button_one'].to_java.isVisible.should be true
  #end
  
  
  #after(:all) do
  #  @gui.frame.dispose()
  #end
  #
end
