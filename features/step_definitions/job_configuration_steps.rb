
When /^I configure the job$/ do
  @job.configure
end

When /^I add a script build step to run "([^"]*)"$/ do |script|
  @job.add_script_step(script)
end

When /^I add always fail build step$/ do
  step %{I add a script build step to run "exit 1"}
end

When /^I tie the job to the "([^"]*)" label$/ do |label|
  @job.configure do
    @job.label_expression = label
  end
end

When /^I tie the job to the slave$/ do
  step %{I tie the job to the "#{@slave.name}" label}
end

When /^I enable concurrent builds$/ do
  step %{I click the "_.concurrentBuild" checkbox}
end

When /^I add a string parameter "(.*?)"$/ do |string_param|
  @job.configure do
    @job.add_parameter("String Parameter",string_param,string_param)
  end
end

When /^I disable the job$/ do
  @job.configure do
    @job.disable
  end
end

Then /^the job should be able to use the "(.*)" buildstep$/ do |build_step|
  find(:xpath, "//button[text()='Add build step']").click
  find(:xpath, "//a[text()='#{build_step}']").instance_of?(Capybara::Node::Element).should be true
end

When /^I set (\d+) builds? to keep$/ do |number|
    step %{I click the "logrotate" checkbox}
    find(:xpath, "//input[@name='logrotate_nums']").set(number)
end
