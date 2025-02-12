import { Link as InertiaLink, InertiaLinkProps } from "@inertiajs/react";
import React from "react";
import type { PathParamsWithQuery, RoutePath } from "../routes";
import Routes from "../routes";

type LinkProps<T extends RoutePath> = Omit<InertiaLinkProps, "href"> & {
  to: T;
  params?: PathParamsWithQuery<T>;
  children: React.ReactNode;
};

export const Link = <T extends RoutePath>({
  to,
  params,
  children,
  ...props
}: LinkProps<T>) => {
  const href = Routes.replaceParams(to, params);

  return (
    <InertiaLink href={href} {...props}>
      {children}
    </InertiaLink>
  );
};
