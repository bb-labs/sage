from pbxproj import XcodeProject
from pbxproj.pbxextensions import TreeType


project = XcodeProject.load("ios/Slide.xcodeproj/project.pbxproj")
config_group = project.get_groups_by_name("Config").pop()
config_file = project.get_files_by_name("Config.xcconfig", parent=config_group)

if config_file:
    project.remove_file_by_id(config_file.pop().get_id())

project.add_file(
    "Config.xcconfig", parent=config_group, tree=TreeType.GROUP, force=True
)

project.save()
