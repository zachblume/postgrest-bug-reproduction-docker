-- Setup for postgrest
\set pgpass `echo "$POSTGRES_PASSWORD"`;

-- a placeholder/mock function
CREATE FUNCTION public.requesting_org_id() RETURNS text AS $$
    SELECT '00000000-0000-0000-0000-000000000007'::text;
$$ LANGUAGE sql;

-- a placeholder/mock function
CREATE FUNCTION public.requesting_user_id() RETURNS text AS $$
    SELECT '00000000-0000-0000-0000-000000000008'::text;
$$ LANGUAGE sql;

-- Create the people table
create table
  public.people (
    batch_id uuid null,
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default current_timestamp,
    inserted_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp with time zone not null default current_timestamp,
    organization_id text not null default requesting_org_id (),
    first_name text null,
    last_name text null,
    addr1 text null,
    addr2 text null,
    city text null,
    state text null,
    zip text null,
    country text null,
    occupation text null,
    employer text null,
    custom_field_1 text null,
    custom_field_2 text null,
    custom_field_3 text null,
    bio text null,
    current_ask_amount integer null,
    name_concat text null,
    user_id text null default requesting_user_id (),
    donor_research text null,
    -- numeric_id integer not null default nextval('people_numeric_id_seq'::regclass),
    constraint people_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.interactions (
    id uuid not null default gen_random_uuid (),
    created_at timestamp with time zone not null default current_timestamp,
    inserted_at timestamp with time zone not null default current_timestamp,
    updated_at timestamp without time zone null,
    batch_id uuid null,
    person_id uuid not null,
    contact_type text null,
    disposition text null,
    disposition_more text null,
    resulted_in_pledge boolean not null default false,
    pledge_id uuid null,
    note text null,
    organization_id text not null default requesting_org_id (),
    call_sid text null,
    ended_at timestamp with time zone null,
    call_session_id bigint null,
    phone_number_id uuid null,
    user_id text null default requesting_user_id (),
    constraint interactions_pkey primary key (id),
    constraint interactions_person_id_fkey foreign key (person_id) references people (id)
    -- constraint interactions_call_session_id_fkey foreign key (call_session_id) references call_sessions (id),
    -- constraint interactions_pledge_id_fkey foreign key (pledge_id) references pledges (id),
    -- constraint interactions_phone_number_id_fkey foreign key (phone_number_id) references phone_numbers (id)
  ) tablespace pg_default;

--   Some examples in people and interactions for testing
insert into people (id, first_name, last_name, addr1, addr2, city, state, zip, country, occupation, employer, custom_field_1, custom_field_2, custom_field_3, bio, current_ask_amount, donor_research, name_concat)
values ('00000000-0000-0000-0000-000000000001', 'John', 'Doe', '1 Main St', 'Apt 1', 'Anytown', 'NY', '12345', 'USA', 'Software Engineer', 'Acme Corp', 'Custom 1', 'Custom 2', 'Custom 3', 'This is a bio', 100, 'This is donor research', 'John Doe');

insert into people (id, first_name, last_name, addr1, addr2, city, state, zip, country, occupation, employer, custom_field_1, custom_field_2, custom_field_3, bio, current_ask_amount, donor_research, name_concat)
values ('00000000-0000-0000-0000-000000000002','Jane', 'Doe', '2 Main St', 'Apt 2', 'Anytown', 'NY', '12345', 'USA', 'Software Engineer', 'Acme Corp', 'Custom 1', 'Custom 2', 'Custom 3', 'This is a bio', 100, 'This is donor research', 'Jane Doe');

insert into people (id, first_name, last_name, addr1, addr2, city, state, zip, country, occupation, employer, custom_field_1, custom_field_2, custom_field_3, bio, current_ask_amount, donor_research, name_concat)
values ('00000000-0000-0000-0000-000000000003','John', 'Smith', '3 Main St', 'Apt 3', 'Anytown', 'NY', '12345', 'USA', 'Software Engineer', 'Acme Corp', 'Custom 1', 'Custom 2', 'Custom 3', 'This is a bio', 100, 'This is donor research', 'John Smith');

insert into interactions (person_id, contact_type, disposition, resulted_in_pledge, note)
values ('00000000-0000-0000-0000-000000000001', 'Call', 'Left Voicemail', false, 'This is a note 1');

insert into interactions (person_id, contact_type, disposition, resulted_in_pledge, note)
values ('00000000-0000-0000-0000-000000000001', 'Call', 'Left Voicemail', false, 'This is a note 2');

insert into interactions (person_id, contact_type, disposition, resulted_in_pledge, note)
values ('00000000-0000-0000-0000-000000000002', 'Call', 'Left Voicemail', false, 'This is a note 3');
