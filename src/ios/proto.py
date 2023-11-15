import sys

from pbxproj import XcodeProject
from pbxproj.pbxextensions import TreeType


project = XcodeProject.load('src/ios/Slide.xcodeproj/project.pbxproj')

# Add protos
proto_group = project.get_groups_by_name('Protos').pop()

for proto in sys.argv[1:]:
    proto_file = project.get_files_by_name(proto, parent=proto_group)

    if proto_file:
        project.remove_file_by_id(proto_file.pop().get_id())

    project.add_file(proto, parent=proto_group, tree=TreeType.GROUP)

project.save()
