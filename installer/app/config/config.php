<?php
AppInstaller::SetInstallerPath("installer");
AppInstaller::SetAppData("Support System Installer","Your complete support ticket system","3.2.4");
AppInstaller::AddCss("css/custom.css");


AppInstaller::AddStep("step1");
AppInstaller::AddStep("step2");
AppInstaller::AddStep("step3");
AppInstaller::AddStep("step4");
AppInstaller::AddStep("finish");