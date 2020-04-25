Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Rowdy Rooster Toolbox"
$Form.AutoScroll = $True
$Form.Width = 400
$Form.Height = 150
$Form.AutoSize = $false
$Form.AutoSizeMode = "GrowandShrink"
 #or GrowOnly
$Form.BackgroundImage = $Item
$Form.BackgroundImageLayout = "Center"
$Form.BackColor = 'Black'
$Form.ShowInTaskbar = $True
$Form.StartPosition = "CenterScreen"

$Dropdown = New-Object System.Windows.Forms.ComboBox
$Dropdown.Location = New-Object System.Drawing.Size(100,10)
$Dropdown.Size = New-Object System.Drawing.Size(130,30)
ForEach ($Item in $DropdownArray) {
    [void] $Dropdown.Items.Add($Item)
    }
[void] $Dropdown.Items.Add("Get-ADComputer")
[void] $Dropdown.Items.Add("Get-ADComputerServiceAccount")
[void] $Dropdown.Items.Add("Get-ADUser")
[void] $Dropdown.Items.Add("Get-ADDomain")
[void] $Dropdown.Items.Add("NA")
[void] $Dropdown.Items.Add("NA")
[void] $Dropdown.Items.Add("Get-ADUser")


    $Form.Controls.Add($DropDown)

    $DropDownLabel = new-object System.Windows.Forms.Label
    $DropDownLabel.Location = new-object System.Drawing.Size(10,10) 
    $DropDownLabel.size = new-object System.Drawing.Size(100,40) 
    $DropDownLabel.Text = "Select Group:"
    $DropDownLabel.ForeColor = "Yellow"
    $Form.Controls.Add($DropDownLabel)

    $Button = new-object System.Windows.Forms.Button
    $Button.Location = new-object System.Drawing.Size(100,50)
    $Button.Size = new-object System.Drawing.Size(100,20)
    $Button.Text = "Continue"
    $Button.Add.Click({Return-DropDown})
    $Button.ForeColor = "Yellow"
    $form.Controls.Add($Button)
    $form.ControlBox = $True

    $Button = new-object System.Windows.Forms.Button
    $Button.Location = new-object System.Drawing.Size(200,50)
    $Button.Size = new-object System.Drawing.Size(100,20)
    $Button.Text = "Exit"
    $Button.Add.Click({Return-DropDown})
    $Button.ForeColor = "Yellow"
    $form.Controls.Add($Button)
    $form.Controls.Add($B_close)
    $form.ControlBox = $True


    $Form.Add_Shown({$Form.Activate()})
    [void] $Form.ShowDialog()


    return $script:choice

$Group = $null
$Group = SelectGroup
while ($Group -like ""){
    $Group = SelectGroup
}
    # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
$Font = New-Object System.Drawing.Font("Times New Roman",24,[System.Drawing.FontStyle]::Bold)
# Font styles are: Regular, Bold, Italic, Underline, Strikeout
$Form.Font = $Font
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "RowdyRooster Toolbox"
$Label.AutoSize = $True
$Form.Controls.Add($Label)
$Form.ShowDialog()

