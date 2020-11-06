requires strict   => 0;
requires warnings => 0;
requires Config   => 0;
requires POSIX    => 0;
requires locale   => 0;

on configure => sub {
    requires 'ExtUtils::MakeMaker' => 0;
};

on build => sub {
    requires 'Test::More' => 0;
    requires 'File::Spec' => 0;
    requires FindBin      => 0;
    requires constant     => 0;
};
