package MooseX::Meta::Method::Role::Authorized::Application::ToInstance;
$MooseX::Meta::Method::Role::Authorized::Application::ToInstance::VERSION = '0.00.05';
use Moose::Role;

after apply => sub {
    my ($self, $role, $instance, $args) = @_;

    my $original_body = $instance->body;
    my $new_body = sub {
        $instance->authorized_do($instance, $original_body, @_)
    };

    # 1 - body is ro in Method, need to force the change,,,
    $instance->{body} = $new_body;

    # 2 - need to reinstall the CODE ref in the glob
    no warnings 'redefine';
    no strict 'refs';
    *{$instance->package_name.'::'.$instance->name} = $new_body;
};

1;
