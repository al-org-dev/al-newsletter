# al-newsletter

`al_newsletter` provides reusable newsletter form and JS handlers for `al-folio` v1.x and compatible Jekyll sites.

## Installation

```ruby
gem 'al_newsletter'
```

```yaml
plugins:
  - al_newsletter
```

## Usage

```liquid
{% al_newsletter_form align=center margin=true %}
```

```liquid
{% al_newsletter_scripts %}
```

## Ecosystem context

- Starter examples/docs live in `al-folio`.
- Newsletter UI/runtime behavior is owned here.

## Contributing

Newsletter behavior and rendering changes should be proposed in this repository.
