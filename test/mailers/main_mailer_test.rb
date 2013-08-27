require 'test_helper'

class MainMailerTest < ActionMailer::TestCase
  tests MainMailer
  
    test "welcome email is shold to delivered " do
      email = MainMailer.welcome(users(:client)).deliver
      
      assert_not ActionMailer::Base.deliveries.empty?

      assert_equal ['notifications@example.com'], email.from
      assert_equal [users(:client).email], email.to
      assert_equal 'Welcome to My Awesome Site', email.subject
      assert_equal read_fixture('welcome_email.txt').join, email.text_part.body.to_s
      assert_equal read_fixture('welcome_email.html').join, email.html_part.body.to_s
    end
    
    test "invoice email is shold to delivered " do
      email = MainMailer.invoice(orders(:kennys_order)).deliver
      
      assert_not ActionMailer::Base.deliveries.empty?

      assert_equal ['notifications@example.com'], email.from
      assert_equal [orders(:kennys_order).email], email.to
      assert_equal 'Thank you for chose our resource', email.subject
      assert_equal read_fixture('invoice_email.txt').join, email.text_part.body.to_s
      assert_equal read_fixture('invoice_email.html').join, email.html_part.body.to_s
    end
end