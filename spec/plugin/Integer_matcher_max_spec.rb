require_relative "../spec_helper"

describe "Integer_matcher_max plugin" do 
  it "matches values up to 2**63-1 by default" do
    app(:Integer_matcher_max) do |r|
      r.is Integer do |i|
        i.to_s
      end
    end

    max = (2**63-1).to_s
    body("/0").must_equal '0'
    body("/#{max}").must_equal max
    body("/#{max.next}").must_equal ''
  end

  it "matches configured values if an argument is provided" do
    app(:bare) do
      plugin :Integer_matcher_max, 2**64-1
      route do |r|
        r.is Integer do |i|
          i.to_s
        end
      end
    end

    max = (2**64-1).to_s
    body("/0").must_equal '0'
    body("/#{max}").must_equal max
    body("/#{max.next}").must_equal ''
  end
end
