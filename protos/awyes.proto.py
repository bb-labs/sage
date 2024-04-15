import pbxproj
import pbxproj.pbxextensions


def save_ios_protos(files):
    project = pbxproj.XcodeProject.load("ios/Sage.xcodeproj/project.pbxproj")

    # Add protos
    proto_group = project.get_groups_by_name("Protos").pop()

    for proto in files:
        proto_file = project.get_files_by_name(proto, parent=proto_group)

        if proto_file:
            project.remove_file_by_id(proto_file.pop().get_id())

        project.add_file(
            proto, parent=proto_group, tree=pbxproj.pbxextensions.TreeType.GROUP
        )

    project.save()
