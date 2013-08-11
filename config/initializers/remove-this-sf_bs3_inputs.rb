# https://github.com/rafaelfranca/simple_form-bootstrap/issues/26
# https://github.com/plataformatec/simple_form/issues/857

# Add class globally to inputs to support 
# https://github.com/plataformatec/simple_form/issues/316
# https://github.com/plataformatec/simple_form/pull/337
# https://github.com/plataformatec/simple_form/pull/622

# SimpleForm applies ".radio" and ".checkbox" classes.
# Having ".radio" with ".radio-inline" or ".checkbox" with ".checkbox-inline"
# causes issues.
# https://github.com/twbs/bootstrap/issues/9067



# https://github.com/rafaelfranca/simple_form-bootstrap/issues/26#issuecomment-22435894
# config/initializers/remove-this-sf_bs3_inputs.rb
inputs = %w[
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end

  Object.const_set(input_type, new_class)
end