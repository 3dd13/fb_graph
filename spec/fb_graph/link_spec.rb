require File.join(File.dirname(__FILE__), '../spec_helper')

describe FbGraph::Link, '#initialize' do

  it 'should setup all supported attributes' do
    attributes = {
      :id => '12345',
      :from => {
        :id => '23456',
        :name => 'nov matake'
      },
      :link => 'http://www.facebook.com/link/12345',
      :message => 'check this out!',
      :updated_time => '2010-01-02T15:37:41+0000'
    }
    link = FbGraph::Link.new(attributes.delete(:id), attributes)
    link.identifier.should   == '12345'
    link.from.should         == FbGraph::User.new('23456', :name => 'nov matake')
    link.link.should         == 'http://www.facebook.com/link/12345'
    link.message.should       == 'check this out!'
    link.updated_time.should == '2010-01-02T15:37:41+0000'
  end

  it 'should support page as from' do
    page_link = FbGraph::Link.new('12345', :from => {
      :id => '23456',
      :name => 'Smart.fm',
      :category => 'Web Site'
    })
    page_link.from.should == FbGraph::Page.new('23456', :name => 'Smart.fm', :category => 'Web Site')
  end

end