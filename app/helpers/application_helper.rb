module ApplicationHelper

  def current_user?(user)
    user == current_user
  end

  def devise_resource_name
    :user
  end

  def devise_resource
    @resource = instance_variable_get(:"@#{devise_resource_name}")
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end

  def xeditable?
    true # Or something like current_user.xeditable?
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end  

  def link_to_trackable(object, object_type)
    if object
      link_to object_type.downcase, object
    else
      "a #{object_type.downcase} which does not exist anymore"
    end
  end  
  
  # def polymorphic_crop_url(action, parent, crop = nil)
  #   parent_class = parent.class.to_s.downcase
  #   if action == "new"
  #     self.send(action + "_" + parent_class + "_crop_url", parent.id)
  #   elsif action == "index"
  #     self.send(action + "_" + parent_class + "_crops_url", parent.id)
  #   elsif action == "show"
  #     self.send(parent_class + "_crop_url", parent.id, crop.id)
  #   else
  #     self.send(action + "_" + parent_class + "_crop_url", parent.id, crop.id)
  #   end
  # end
  
  # def polymorphic_yield_url(action, parent, crop, crop_yield = nil)
  #   parent_class = parent.class.to_s.downcase
    
  #   if action == "new"
  #     self.send(action + "_" + parent_class + "_crop_yield_url", parent.id, crop.id)
  #   elsif action == "index"
  #     self.send(action + "_" + parent_class + "_crop_yields_url", parent.id, crop.id)
  #   elsif action == "show"
  #     self.send(parent_class + "_crop_yield_url", parent.id, crop.id, crop_yield.id)
  #   else
  #     self.send(action + "_" + parent_class + "_crop_yield_url", parent.id, crop.id, crop_yield.id)
  #   end
  # end

end