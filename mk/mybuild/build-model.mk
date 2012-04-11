# Generated by Xpand using M2Make template.

# Model of 'build' package.

ifndef __mybuild_build_model_mk
__mybuild_build_model_mk := 1

include mk/model/model_impl.mk

#
# Model object 'Build'.
#
# The following features are defined:
#   - reference 'modules'
#
define class-BuildBuild
	# Extends 'EObject' class (implicitly).
	$(eobject Build_Build,
		BuildBuild,,)

	# Property 'modules... : BuildModuleInstance'.
	$(eobject-reference Build_Build_modules,
		modules,BuildModuleInstance,configuration,changeable many containment)

	# PROTECTED REGION ID(Build_Build) ENABLED START
	$(property-field issueReceiver : IssueReceiver)

	$(map moduleInstanceByName : BuildModuleInstance)

	# PROTECTED REGION END
endef

#
# Model object 'ModuleInstance'.
#
# The following features are defined:
#   - reference 'configuration'
#   - reference 'type'
#   - reference 'dependent'
#   - reference 'depends'
#   - reference 'options'
#   - reference 'includeMember'
#
define class-BuildModuleInstance
	# Extends 'EObject' class (implicitly).
	$(eobject Build_ModuleInstance,
		BuildModuleInstance,,)

	# Property 'configuration : BuildBuild'.
	$(eobject-reference Build_ModuleInstance_configuration,
		configuration,BuildBuild,modules,changeable container)

	# Property 'type : MyModule'.
	$(eobject-reference Build_ModuleInstance_type,
		type,MyModule,,changeable)

	# Property 'dependent... : BuildModuleInstance'.
	$(eobject-reference Build_ModuleInstance_dependent,
		dependent,BuildModuleInstance,depends,changeable many)

	# Property 'depends... : BuildModuleInstance'.
	$(eobject-reference Build_ModuleInstance_depends,
		depends,BuildModuleInstance,dependent,changeable many)

	# Property 'options... : BuildOptionInstance'.
	$(eobject-reference Build_ModuleInstance_options,
		options,BuildOptionInstance,module,changeable many containment)

	# Property 'includeMember : CfgInclude'.
	# Property 'includeMember_link : ELink'.
	$(eobject-reference Build_ModuleInstance_includeMember,
		includeMember,CfgInclude,,changeable linkable)

	# PROTECTED REGION ID(Build_ModuleInstance) ENABLED START
	# PROTECTED REGION END
endef

#
# Model object 'OptionInstance'.
#
# The following features are defined:
#   - reference 'module'
#   - reference 'option'
#   - reference 'optionValue'
#
define class-BuildOptionInstance
	# Extends 'EObject' class (implicitly).
	$(eobject Build_OptionInstance,
		BuildOptionInstance,,)

	# Property 'module : BuildModuleInstance'.
	$(eobject-reference Build_OptionInstance_module,
		module,BuildModuleInstance,options,changeable container)

	# Property 'option : MyOption'.
	# Property 'option_link : ELink'.
	$(eobject-reference Build_OptionInstance_option,
		option,MyOption,,changeable linkable)

	# Property 'optionValue : MyOptionValue'.
	$(eobject-reference Build_OptionInstance_optionValue,
		optionValue,MyOptionValue,,changeable)

	# PROTECTED REGION ID(Build_OptionInstance) ENABLED START
#	# TODO Add custom implementation here and remove this comment.
	# PROTECTED REGION END
endef

# PROTECTED REGION ID(Build) ENABLED START
# TODO Add custom implementation here and remove this comment.
# PROTECTED REGION END

$(def_all)

endif # __mybuild_build_model_mk

