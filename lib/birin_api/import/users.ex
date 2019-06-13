defmodule BirinApi.Import.Users do
  alias BirinApi.Import.Common
  alias BirinApi.Accounts.User

  def from_csv_file(filename), do: Common.from_csv_file(filename, &map_fields/1)

  defp map_fields(%{
         "OBSNAME" => name,
         "PERMIT" => license_number,
         "INIT" => initials,
         "SUPERVISOR" => _supervisor,
         "ACTIVE" => _active
       }) do
    %User{
      name: empty_str_to_nil(name),
      license_number: empty_str_to_nil(license_number),
      initials: empty_str_to_nil(initials)
    }
  end

  defp empty_str_to_nil(""), do: nil
  defp empty_str_to_nil(str), do: str
end
