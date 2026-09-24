*** Settings ***
Documentation    Test cases for fresh-editor snap
Resource         kvm.resource


*** Test Cases ***
Fresh Editor Launches And Renders
    [Documentation]    Verify fresh-editor snap launches and renders a UI on Mir
    [Tags]    smoke    yarf:certification_status: blocker
    Log Screenshot
