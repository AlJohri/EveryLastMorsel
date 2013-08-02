class CropsController < InheritedResources::Base
	layout "generic"
	has_scope :page, :default => 1
end
