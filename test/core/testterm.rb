#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/core/term'

class TermTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  # Test exception thrown on invalid confirmation key.
  def test_confirm
    assert_raise( RuntimeError) { Tui::Core::Term::confirm( '', 'x'); }
  end # test_confirm

end # TermTestCase

