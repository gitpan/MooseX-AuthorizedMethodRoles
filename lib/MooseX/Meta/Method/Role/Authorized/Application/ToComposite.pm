package MooseX::Meta::Method::Role::Authorized::Application::ToComposite;
$MooseX::Meta::Method::Role::Authorized::Application::ToComposite::VERSION = '0.00.04';
use Moose::Role;

after apply => sub {
    my ($self, $role_source, $role_dest, $args) = @_;
    use Data::Dumper;
#warn("init to comp $self, $role_source,=". $role_dest->name.",".Dumper( $args));
    Moose::Util::MetaRole::apply_metaroles
        (
         for            => $role_dest,
         role_metaroles =>
         {
          application_to_role =>
          ['MooseX::Meta::Method::Role::Authorized::Application::ToComposite'],
          application_to_class =>
          ['MooseX::Meta::Method::Role::Authorized::Application::ToClass'],
          application_to_instance    =>
          ['MooseX::Meta::Method::Role::Authorized::Application::ToInstance'],
         }
        );

};

1;
