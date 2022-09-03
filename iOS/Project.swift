import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "UNITHON-Team6-iOS",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: []
)
