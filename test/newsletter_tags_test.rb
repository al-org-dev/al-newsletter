require 'minitest/autorun'
require 'liquid'

require_relative '../lib/al_newsletter'

class AlNewsletterTagsTest < Minitest::Test
  Site = Struct.new(:config)
  FakeSite = Struct.new(:static_files)

  def render_form(markup:, config:)
    template = Liquid::Template.parse("{% al_newsletter_form #{markup} %}")
    template.render({}, registers: { site: Site.new(config) })
  end

  def render_scripts(site_hash)
    template = Liquid::Template.parse('{% al_newsletter_scripts %}')
    template.render({ 'site' => site_hash })
  end

  def test_renders_left_aligned_form_with_margin
    output = render_form(
      markup: 'align=left margin=true',
      config: {
        'newsletter' => { 'endpoint' => 'abc123' }
      }
    )

    assert_includes output, 'action="https://app.loops.so/api/newsletter-form/abc123"'
    assert_includes output, 'style="justify-content: flex-start"'
    assert_includes output, 'style="margin: 20px"'
  end

  def test_renders_center_aligned_form_by_default
    output = render_form(
      markup: '',
      config: {
        'newsletter' => { 'endpoint' => 'abc123' }
      }
    )

    assert_includes output, 'style="justify-content: center"'
  end

  def test_returns_empty_when_newsletter_config_missing
    output = render_form(markup: '', config: {})
    assert_equal '', output
  end

  def test_renders_newsletter_script_with_baseurl
    output = render_scripts('baseurl' => '/base')

    assert_includes output, '/base/assets/al_newsletter/js/newsletter.js'
  end

  def test_assets_generator_registers_newsletter_js
    site = FakeSite.new([])

    AlNewsletter::AssetsGenerator.new.generate(site)

    names = site.static_files.map(&:name)
    assert_includes names, 'newsletter.js'
  end
end
