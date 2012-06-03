module TimeEntries
	module Patches
		module LinkedTimeEntriesPatch
			def self.included(base) # :nodoc:
				#base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
					alias_method_chain :format_criteria_value, :linked			
				end
			end
      
		module ClassMethods
			
		end
      
		module InstanceMethods	  
			def format_criteria_value_with_linked(criteria_options, value)
				if value.blank?
					"[#{l(:label_none)}]"
				elsif k = criteria_options[:klass]
					obj = k.find_by_id(value.to_i)
					if obj.is_a?(Issue)
						obj.visible? ? "#{obj.tracker} " + (link_to "##{obj.id}: #{obj.subject}", {:controller => "issues", :action => "show", :id => obj.id}) : "##{obj.id}"
					else
						obj
				end
				else      
					format_value(value, criteria_options[:format])
				end        
			end
		end
	end
  end
end
